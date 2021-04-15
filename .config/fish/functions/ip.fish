# Defined in - @ line 1
function ip --wraps='ip -c' --description 'alias ip=ip -c'
 command ip -c $argv;
end
