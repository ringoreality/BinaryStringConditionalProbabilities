# BinaryStringConditionalProbabilities
matlab script that calculates conditional probabilities for a binary string

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
