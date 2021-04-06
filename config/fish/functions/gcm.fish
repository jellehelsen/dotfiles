# Defined in - @ line 1
function gcm --wraps='git checkout main' --description 'alias gcm=git checkout main'
  git checkout main $argv;
end
