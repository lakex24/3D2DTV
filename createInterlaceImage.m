% Convert original stereo images into one interlaced stereo image (passive)
% Input two original left and right images (dimensions must match)
% Output interlaced left and right images
function out_interlaced = createInterlaceImage(in_L, in_R)

% in_L, in_R dimension should match
[l_row l_col l_ch] = size(in_L);
[r_row r_col r_ch] = size(in_R);

if (l_row ~= r_row || l_col ~= r_col || l_ch ~= r_ch)
    disp('ERROR: Left and Right Stereo Images dimensions don''t match!');
end

row = l_row;
col = l_col;
channel = l_ch;

out_interlaced = in_L;
out_interlaced(1:2:row, :, :) = in_R(1:2:row, :, :);