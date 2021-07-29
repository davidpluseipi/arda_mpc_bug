function out = copy_from(in, out)

p = properties(in);
for i = 1:numel(p)
   if ~isa(in.(p{i}), 'handle')
       out.(p{i}) = in.(p{i});
   end
end

end