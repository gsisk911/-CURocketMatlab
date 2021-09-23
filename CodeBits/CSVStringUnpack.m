function vars = CSVStringUnpack(str)
    comma_idx = find(str == ',');
    commas = length(comma_idx);
    vars = [];
    vars = [vars,string(extractBefore(str,comma_idx(1)))];
    for i = 2:commas
        vars = [vars,string(extractBetween(str,comma_idx(i-1)+1,comma_idx(i)-1))];
    end
    vars = [vars,string(extractAfter(str,comma_idx(commas)))];
end
