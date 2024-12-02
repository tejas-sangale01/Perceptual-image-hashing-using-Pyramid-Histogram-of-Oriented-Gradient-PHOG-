function [ PHOG_hist, varargout ] = desc_PHOG( img, varargin )
   
    
    img = double(img);
    
    if nargin == 2
        options = varargin{1};
    else
        options = struct;
    end
    
    if isfield(options,'gridHist') && length(options.gridHist) == 2
        rowNum = options.gridHist(1);
        colNum = options.gridHist(2);
    elseif isfield(options,'gridHist') && length(options.gridHist) == 1
        rowNum = options.gridHist;
        colNum = options.gridHist;
    else
        rowNum = 1;
        colNum = 1;
    end
    
    if isfield(options,'bin')
        bin = options.bin;
    else
        bin = 2;
    end
        
    if isfield(options,'angle')
        angle = options.angle;
    else
        angle = 180;
    end   
        
    if isfield(options,'L')
        L = options.L;
    else
        L = 2;
    end
    
    roi = [1;size(img,1);1;size(img,2)];
    
    [~, bh_roi, bv_roi] = descriptor_PHOG(img,bin,angle,L,roi);
    
    imgDesc(1).fea = bh_roi;
    imgDesc(2).fea = bv_roi;
    
    options.L = L; options.bin = bin; options.binVec = [];
    options.phogHist = 1;
    
    if nargout == 2
        varargout{1} = imgDesc;
    end
    
    if rowNum == 1 && colNum == 1       
        PHOG_hist = anna_phogDescriptor(bh_roi,bv_roi,options.L,options.bin)';
        if isfield(options,'mode') && strcmp(options.mode,'nh')
            PHOG_hist = PHOG_hist ./ sum(PHOG_hist);
        end
    else
        PHOG_hist = ct_gridHist(imgDesc, rowNum, colNum, options);
    end
end