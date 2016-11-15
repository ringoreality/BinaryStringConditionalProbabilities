function out = conditionalProb(x, length)
% CONDITIONALPROB  calculate conditional probabilities given an input binary string and designated neighborhood length
%	INPUTS
%	x should be a binary string, e.g. x = [1, 0, 1, 0, 0, 1, ...]
%	length specifies how far to the left the neighborhood is defined
%	OUTPUTS
%	out is a struct that contains the calculated stats
%   out.bins contains all bit value combinations of the given length
%   out.counts contains the occurrences of 0/1 given each of the bit value combination
%   out.selections contains all combinations of bit selection and corresponding 0/1 counts
%   ---------------------------
%		EXAMPLE given length = 3
%			there are 2^3 binary combinations of left side bits, (000, 001, 010, 011, 100, 101, 110, 111)
%			there are 2^3 - 1 combinations of bit selections, (a, b, c, ab, ac, bc, abc)
%			thus, the conditional probabilities are:
%				P(0/1 | a), P(0/1 | b), P(0/1 | c) ...each bit selection has 2 states
%				P(0/1 | ab), P(0/1 | ac), P(0/1 | bc) ...each bit selection has 4 states
%				p(0/1 | abc) ...the bit selection has 8 states
%				P(0/1 | none) ...global counts for 0/1 occurrences in the binary string
%   ---------------------------
%	coded by RINGO


% test binary string
% x = randi([0 1],1,10000);

out = struct();

if size(x,1) > size(x,2)
	x = x';
	if size(x,1) ~= 1
		warning('input binary string should be a row vector!');
	end
end

bins = dec2bin([0:2^length-1]) - '0'; % binary combinations of each event
counts = zeros(size(bins,1), 2); % count conditional events
for i = 1 : size(x,2) - length
	event = x(1, i:i+length-1);
	truth = x(1, i+length);
	[~, idx] = ismember(event,bins,'rows');
	counts(idx,truth+1) = counts(idx,truth+1) + 1;
end

selections = cell([1,length]);
for i = 1 : length
	selections{i} = combnk([0:length-1],i);
end

out.bins = bins;
out.counts = counts;

out.selections = struct();
out.selections.bins = cell(1, 2^length);
out.selections.counts = cell(1, 2^length);
% unconditional counts, global 0/1 counts
out.selections.bins{2^length} = zeros(1,length);
out.selections.counts{2^length} = sum(counts,1);
% conditional counts
selections = dec2bin([1:2^length-1])-'0';
for i = 1 : 2^length-1
	out.selections.bins{i} = selections(i,:);
	out.selections.counts{i} = merge(counts, bins, out.selections.bins{i});
end

end