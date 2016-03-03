function visualiseFA(dim, inputV1, inputFA, fps, varargin)
% Input parameters:
%   inputV1 = the v1 image file, assumed to be MxNxOx3
%   inputFA = the FA image file, assumed to be MxNxO (same dimensions as
%   previous image
%_______________________________________________________________________

    V1 = load_nii(inputV1);
    FA = load_nii(inputFA);

    filename = 'animation.gif';
    if (exist(filename))
        delete(filename);
    end
    img = V1.img;
    
    %apply a maximum to our FA
    ceiled = min(FA.img, 1);
    
    if (dim == 3)
        for i = 1:size(V1.img, 3)
            r = abs(squeeze(V1.img(:,:,i,1))) .*  ceiled(:, :, i);
            g = abs(squeeze(V1.img(:,:,i,2))) .*  ceiled(:, :, i);
            b = abs(squeeze(V1.img(:,:,i,3))) .*  ceiled(:, :, i);

            img(:,:,i,1) = r;
            img(:,:,i,2) = g;
            img(:,:,i,3) = b;
            image(squeeze(img(:, :, i, :)));
            %# figure
            set(gca, 'nextplot','replacechildren', 'Visible','off');
            set(gcf, 'Color' ,'black'); % set background to be black
            axis tight
            drawnow;

            % retrieve the frame
            A = getframe(gca);
            % convert it in a colormap
            [IND, map] = rgb2ind(A.cdata(:,:,:),256, 'nodither');

            % crete if needed or just append if exist already
            if ~exist(filename,'file')
                imwrite(IND,map,filename,'gif','WriteMode','overwrite','delaytime',1/fps,'LoopCount',inf, varargin{:});
            else
                imwrite(IND,map,filename,'gif','WriteMode','append','delaytime',1/fps,varargin{:});    
            end
        end
    elseif (dim == 2)
        for i = 1:size(V1.img, 2)
            r = abs(squeeze(V1.img(:,i,:,1))) .*  squeeze(ceiled(:, i, :));
            g = abs(squeeze(V1.img(:,i,:,2))) .*  squeeze(ceiled(:, i, :));
            b = abs(squeeze(V1.img(:,i,:,3))) .*  squeeze(ceiled(:, i, :));

            img(:,i,:,1) = r;
            img(:,i,:,2) = g;
            img(:,i,:,3) = b;
            image(squeeze(img(:, i, :, :)));
            %# figure
            set(gca, 'nextplot','replacechildren', 'Visible','off');
            set(gcf, 'Color' ,'black'); % set background to be black
            axis tight
            drawnow;

            % retrieve the frame
            A = getframe(gca);
            % convert it in a colormap
            [IND, map] = rgb2ind(A.cdata(:,:,:),256, 'nodither');

            % crete if needed or just append if exist already
            if ~exist(filename,'file')
                imwrite(IND,map,filename,'gif','WriteMode','overwrite','delaytime',1/fps,'LoopCount',1, varargin{:});
            else
                imwrite(IND,map,filename,'gif','WriteMode','append','delaytime',1/fps,varargin{:});    
            end
        end
    else
        for i = 1:size(V1.img, 1)
            r = abs(squeeze(V1.img(i,:,:,1))) .*  squeeze(ceiled(i, :, :));
            g = abs(squeeze(V1.img(i,:,:,2))) .*  squeeze(ceiled(i, :, :));
            b = abs(squeeze(V1.img(i,:,:,3))) .*  squeeze(ceiled(i, :, :));

            img(i,:,:,1) = r;
            img(i,:,:,2) = g;
            img(i,:,:,3) = b;
            image(squeeze(img(i, :, :, :)));
            %# figure
            set(gca, 'nextplot','replacechildren', 'Visible','off');
            set(gcf, 'Color' ,'black'); % set background to be black
            axis tight
            drawnow;

            % retrieve the frame
            A = getframe(gca);
            % convert it in a colormap
            [IND, map] = rgb2ind(A.cdata(:,:,:),256, 'nodither');

            % crete if needed or just append if exist already
            if ~exist(filename,'file')
                imwrite(IND,map,filename,'gif','WriteMode','overwrite','delaytime',1/fps,'LoopCount',1, varargin{:});
            else
                imwrite(IND,map,filename,'gif','WriteMode','append','delaytime',1/fps,varargin{:});    
            end
        end
    end
    winopen(filename)
end