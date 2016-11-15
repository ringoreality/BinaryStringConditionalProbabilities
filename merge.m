function out = merge(x, bins, select)
% MERGE  merge rows of x given bit selection
%	INPUTS
%	x is a matrix whose rows need to be merged given bit selecton
%	select specifies the bit selection
%	size(x,1) == 2^size(select,2) should hold
%	OUTPUTS
%	out is a matrix after merge
%	EXAMPLE
%	x = [	valueFor(000);
%			valueFor(001);
%			valueFor(010);
%			valueFor(011);
%			valueFor(100);
%			valueFor(101);
%			valueFor(110);
%			valueFor(111);	]
%	given select = [0 1 1], the last two bits are selected, and thus the first bit's values need to be merged
%	thus out = [	valueFor[000] + valueFor[100];
%					valueFor[001] + valueFor[101];
%					valueFor[010] + valueFor[110];
%					valueFor[011] + valueFor[111];	]
%	coded by RINGO

% generate all full length indices for the current bit selection
temp = dec2bin(0:2^(size(select,2)-sum(select))-1) - '0';
comb = 0:2^sum(select)-1;
comb = sort(repmat(comb,1,2^(size(select,2)-sum(select))));;
comb = dec2bin(comb)-'0';
i = find(~select);
indices = repmat(select,2^(size(select,2)-sum(select)),1);
indices(:,i) = temp;
indices = repmat(indices,2^sum(select==1),1);
j = find(select);
indices(:,j) = comb;

% add up 2^(size(select,2)-sum(select==1)) elements together
out = [];
[~, idx] = ismember(indices,bins,'rows');
idx = reshape(idx, 2^(size(select,2))/2^(sum(select==1)), 2^(sum(select==1)));
for ii = 1 : size(idx,2)
	out = [out; sum(x(idx(:,ii),:),1)];
end

end