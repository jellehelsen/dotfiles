#!/usr/bin/env ruby
require "osx/cocoa"
require "readline"
require 'io/wait'

OSX.require_framework 'AddressBook'
include OSX
require 'pty'
OSX.ns_import :ABPerson

class ABPerson

  # Pull first and last name, organization, and record flags
  # If the entry is a company, display the organization name instead
  def displayName
    firstName = valueForProperty(KABFirstNameProperty)
    lastName = valueForProperty(KABLastNameProperty)
    companyName = valueForProperty(KABOrganizationProperty)
    flagsValue = valueForProperty(KABPersonFlags)

    flags = flagsValue ? flagsValue.intValue : 0
    if (flags & KABShowAsMask) == KABShowAsCompany
      return companyName if companyName and companyName.length > 0
    end
    
    lastNameFirst = (flags & KABNameOrderingMask) == KABLastNameFirst
    hasFirstName = firstName and firstName.length > 0
    hasLastName = lastName and lastName.length > 0
  
    if hasLastName and hasFirstName
      if lastNameFirst
        "#{lastName} #{firstname}"
      else
        "#{firstName} #{lastName}"
      end
    elsif hasLastName
      lastName
    else
      firstName
    end
  end
  
end

from_line = STDIN.read.scan(/^From: .+/)[0]
puts from_line
email_address = from_line.scan(/[\w|\.|_|\-|\+]+@[\w|_|-]+\.[a-z]+/)[0]
puts email_address
search_element = ABPerson.searchElementForProperty_label_key_value_comparison(ABPerson::KABEmailProperty, nil, nil, email_address, ABPerson::KABEqualCaseInsensitive)
found_people = ABAddressBook.sharedAddressBook.recordsMatchingSearchElement(search_element)
unless found_people.count == 0
  puts "email address #{email_address} already registered to #{found_people[0].displayName}"
  exit(0)
end

full_name = `awk -F'[:|<]' '{ print $2 }' << EODATA
#{from_line}
EODATA`.strip
names = full_name.split(' ')
first_name = names.shift
name = names.join(' ')

search_firstname = ABPerson.searchElementForProperty_label_key_value_comparison(ABPerson::KABFirstNameProperty, nil,nil, first_name, ABPerson::KABEqualCaseInsensitive)
search_lastname = ABPerson.searchElementForProperty_label_key_value_comparison(ABPerson::KABLastNameProperty, nil,nil, name, ABPerson::KABEqualCaseInsensitive)
search_fullname = ABSearchElement.searchElementForConjunction_children(ABSearchElement::KABSearchAnd, [search_lastname, search_firstname]) 
found_people = ABAddressBook.sharedAddressBook.recordsMatchingSearchElement(search_fullname)
unless found_people.count == 0
  person = found_people[0]
  puts "adding #{email_address} to existing person #{person.displayName}"
end

puts "adding #{first_name} #{name} <#{email_address}> to addressbook" if person.nil?

new_person = person.nil?

person ||= ABPerson.alloc.init

person.setValue_forProperty(first_name, ABPerson::KABFirstNameProperty) if new_person
person.setValue_forProperty(name, ABPerson::KABLastNameProperty) if new_person
ABAddressBook.sharedAddressBook.addRecord(person) if new_person
emails = person.valueForProperty(ABPerson::KABEmailProperty).mutableCopy rescue nil
emails ||= ABMutableMultiValue.alloc.init
emails.addValue_withLabel(email_address, 'Work')
# puts emails.inspect

person.setValue_forProperty(emails, ABPerson::KABEmailProperty)
ABAddressBook.sharedAddressBook.save
# print "email address: #{email_address}\n Is this correct? [Y/n]"

# STDERR.sync = true
# pty = PTY.getpty[1]
# 
# puts pty.tty?
# # pty.open('r')
# if pty.ready?
#   responce = pty.readline
#   if responce == 121 || responce == 89
#     puts 'ok'
#   end
#   
# end
# addressbook = SBApplication.applicationWithBundleIdentifier("com.apple.AddressBook")
# STDIN.grep(/From: /) do |line|
#   puts line.scan(/<.+>/)[0].scan(/!([<|>])+/)
# end
