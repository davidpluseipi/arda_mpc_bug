function log_error(arda, message)
    i = length(arda.errors)+1;
    arda.errors(i) = {message};
end