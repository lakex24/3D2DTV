clear; clc;

in_stereo_folder = './StereoImages/origin/';
%out_folder       = './Converted/';
out_folder       = './StereoImages/';

ext = '.jpg';
in_filenames = dir([in_stereo_folder '*' ext]);

% Laptop screen resolution
% ROW = 900;
% COL = 1600;

% 3DTV screen resolution
ROW = 1080;
COL = 1920;

for i = 1:length(in_filenames)

    in_filename = in_filenames(i).name;
    in_filepath = [in_stereo_folder in_filename];
    
    in_stereo = imread(in_filepath);
    
    is_LR_swapped = false;
    [in_L in_R]   = splitStereo(in_stereo, is_LR_swapped);
    
    in_L = imresize(in_L, [ROW COL]);
    in_R = imresize(in_R, [ROW COL]);
    in_R = in_R * 0.4;
    
    out_stereo = createInterlaceImage(in_L, in_R);
    
    % File name without suffix
    fname = in_filename(1:(length(in_filename) - length(ext)));
    
    out_filepath = [out_folder fname '_interlaced' ext];
    imwrite(out_stereo, out_filepath);

    % Display
    msg = ['Processed Image ' in_filename];
    disp(msg);
end