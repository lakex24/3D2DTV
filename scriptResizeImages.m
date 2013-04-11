% Resize images to fit different screen resolutions
% Keep original image width/height ratio

clear; clc;
disp('Resize Images started...');

% Laptop screen resolution
ROW = 900;
COL = 1600;
resolution = '1600x900';

% 3DTV screen resolution
% ROW = 1080;
% COL = 1920;
% resolution = '1920x1080';

% Input / Output Image folders
in_stereo_folder = './StereoImages/';
out_folder       = ['./StereoImages/' resolution '/'];

ext = '.jpg';
in_filenames = dir([in_stereo_folder '*' ext]);

for i = 1:length(in_filenames)

    in_filename = in_filenames(i).name;
    in_filepath = [in_stereo_folder in_filename];
    
    in_stereo = imread(in_filepath);
    
    is_LR_swapped = true;
    [in_L in_R]   = splitStereo(in_stereo, is_LR_swapped);
    
    % Generate size-adjusted stereo
    [out_L out_R] = adjustImageSize(in_L, in_R);

    out_stereo    = mergeStereo(out_L, out_R);
    
    
    [row col channel] = size(out_L);
    for r = 1:row
        for c = 1:col
            L_val = 0;
            for k = 1:channel
                % Perform conversion on each pixel, each channel
                L_val = L_val + out_L(r, c, k);
            end
            if L_val < 30
                out_L(r, c, :) = out_L(r, c, :) * 3.0;
            end
        end
    end
    
    
    
    fname = in_filename(1:(length(in_filename) - length(ext)));
    
    out_filepath = [out_folder fname '_' ext]; 
    imwrite(out_stereo, out_filepath);
    
    out_filepath = [out_folder fname '_L' ext]; 
    imwrite(out_L, out_filepath);
    
    out_filepath = [out_folder fname '_R' ext]; 
    imwrite(out_R, out_filepath);
    
    msg = ['Processed Image ' in_filename];
    disp(msg);
end