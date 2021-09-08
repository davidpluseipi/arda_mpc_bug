function v_out = pad_zeros(v, n)

if isnumeric(v)
    v_str = num2str(v);
else
    v_str = v;
end

while n > numel(v_str)
    v_str = ['0' v_str];
end



v_out = v_str;
end