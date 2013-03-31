% Basic Operations for Merging Stereo Images
function out_stereo = mergeStereo(in_L, in_R)

% in_L, in_R dimension should match
[l_row l_col l_ch] = size(in_L);
[r_row r_col r_ch] = size(in_R);

if (l_row ~= r_row || l_col ~= r_col || l_ch ~= r_ch)
    disp('ERROR: Left and Right Stereo Images dimensions don''t match!');
end

out_stereo = [in_L in_R];