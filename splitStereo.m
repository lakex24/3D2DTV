% Basic Operations for Splitting Stereo Images
function [out_L out_R] = splitStereo(in_stereo, is_LR_swapped)

[row col ch] = size(in_stereo);

if (mod(col, 2) ~= 0)
    msg = ['WARN: COL is an odd number! COL = ' num2str(col)]; 
    disp(msg);
end

if (is_LR_swapped)
    out_R = in_stereo(:, 1:(col/2),       :);
    out_L = in_stereo(:, (col/2 + 1):col, :);
else
    out_L = in_stereo(:, 1:(col/2),       :);
    out_R = in_stereo(:, (col/2 + 1):col, :);
end