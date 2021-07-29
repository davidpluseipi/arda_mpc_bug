function H = copy_from(B,H)

p = properties(B);
for i = 1:numel(p)
   if ~isa(B.(p{i}), 'listener')
       H.(p{i}) = B.(p{i});
   end
end

end