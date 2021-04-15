# Defined in - @ line 1
function gc --wraps='git commit' --description 'alias gc=git commit'
  git commit $argv;
end
