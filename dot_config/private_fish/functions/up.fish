function up --wraps='paru && pacdiff -s' --description 'alias up paru && pacdiff -s'
    paru
    pacdiff -s $argv

end
