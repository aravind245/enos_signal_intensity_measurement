% -------------------------------------------------------------------------
% MATLAB Script for Extracting Maximum Area Intensity from TIFF Images
% -------------------------------------------------------------------------
% Author: [Aravind Sivakumar]
% Date: [10/1/2025]
% Description:
% This script processes all `.tif` images in a specified folder, extracts
% the intensity of the largest segmented area from each image, and saves
% the results into a CSV file. The script is intended for use in analyzing
% fluorescence or intensity-based imaging data.

% -------------------------------------------------------------------------
% Clearing workspace and initializing paths
% -------------------------------------------------------------------------
clc;        % Clear command window
clear all;  % Clear all variables
close all;  % Close all figure windows

% Define the folder containing input images
myfolder = 'C:\Users\User\OneDrive\Desktop\40 Days enos';

% Define destination directory for results and create it if not existing
destdir = 'C:\Users\User\OneDrive\Desktop\40 Days enos\results';
mkdir(destdir);

% -------------------------------------------------------------------------
% Load all TIFF image filenames in the specified folder
% -------------------------------------------------------------------------
fullfilelist = dir(fullfile(myfolder, '*.tif')); % Get all .tif files in folder
filenamesfull = {fullfilelist.name}'; % Extract file names into a cell array

% Initialize results structure
analyzeresults = struct([]);

% -------------------------------------------------------------------------
% Process each image
% -------------------------------------------------------------------------
for count = 1:length(filenamesfull)
    % Extract the filename
    filename = filenamesfull{count};
    
    % Store filename in results structure
    analyzeresults(count).filename = filename;
    
    % Generate a pattern for creating subdirectories
    filenamepattern = filename(1:end-4); % Remove '.tif' extension
    destdir2 = fullfile(destdir, filenamepattern);
    mkdir(destdir2); % Create subfolder for results

    % Read the raw image
    Imgraw = imread(fullfile(myfolder, filename));
    
    % Display the image (optional)
    figure;
    imshow(Imgraw);

    % Extract intensity of the largest area
    intensity = extractMaxAreaIntensity(Imgraw);
    
    % Store extracted intensity in results structure
    analyzeresults(count).intensity = intensity;

    % Close all open figures to avoid clutter
    close all;
end

% -------------------------------------------------------------------------
% Convert results structure to table and save as CSV
% -------------------------------------------------------------------------
resultstable1 = struct2table(analyzeresults);
writetable(resultstable1, 'intensities.csv');

% -------------------------------------------------------------------------
% Function: Extract Maximum Area Intensity
% -------------------------------------------------------------------------
function correspondingIntensity = extractMaxAreaIntensity(image)
    % This function processes a given image to extract the mean intensity
    % of the largest segmented area after preprocessing.
    
    % Convert to grayscale components (assuming RGB input)
    I2 = image(:,:,2); % Extract green channel (if relevant)

    % Preprocess the image: adjust contrast, apply median filter, and close
    It = imadjust(I2);                % Enhance contrast
    It = medfilt2(It, [2,2]);          % Apply median filtering
    se1 = strel('disk', 30, 8);        % Define structuring element
    It = imclose(It, se1);             % Morphological closing operation

    % Binarize image and remove small objects
    Ib = imbinarize(It);
    Ib = bwareaopen(Ib, 1000);         % Remove small noise
    Ib = imclearborder(Ib);            % Clear border artifacts

    % Mask the original image
    Im = I2;
    Im(~Ib) = 0;                       % Retain only segmented areas

    % Extract regions' properties: areas and mean intensities
    areas = regionprops(Ib, I2, 'Area');
    arealist = [areas.Area];

    props = regionprops(Ib, I2, 'MeanIntensity');
    allIntensities = [props.MeanIntensity];

    % Find the intensity corresponding to the largest area
    [~, maxIndex] = max(arealist);
    correspondingIntensity = allIntensities(maxIndex);
end
