
while(1)  
    figure(1)
    hold off;
    imshow(im);
    
    imwidth=size(im,2);
    imheight=size(im,1);
    
    hold on;
    [xx,yy,button]=ginput(1)
    plot(xx,yy,'yo');
    [xx2,yy2,button2]=ginput(1);    
    plot(xx2,yy2,'yo');
    plot(xx,yy2,'yo');
    plot(xx2,yy,'yo');
    
    plot([xx xx2],[yy yy],'b');
    plot([xx xx2],[yy2 yy2],'b');
    plot([xx xx],[yy yy2],'b');
    plot([xx2 xx2],[yy yy2],'b');
    
    p1 =[xx yy];
    p2 =[xx yy2];
    p3 =[xx2 yy];
    p4 =[xx2 yy2];
    
    [xx,yy,button]=ginput(1);
    if button == 27
        break;
    elseif button ==100
        width  = p3(1) - p1(1);
        height = p2(2) - p1(2);
        midx = (p3(1) + p1(1))/2;
        midy = (p2(2) + p1(2))/2;
        
        plot(midx,midy,'yo');
        scale =0.75
        xxbar  = int32(midx -scale*width);
        xx2bar = int32(midx +scale*width);
        yybar  = int32(midy -scale*height);
        yy2bar = int32(midy +scale*height);
        
        wp1=[xxbar yybar];
        wp2=[xxbar yy2bar];
        wp3=[xx2bar yybar];
        wp4=[xx2bar yy2bar];
        
        plot([wp1(1) wp2(1)],[wp1(2) wp2(2)],'b');
        plot([wp1(1) wp3(1)],[wp1(2) wp3(2)],'b');
        plot([wp2(1) wp4(1)],[wp2(2) wp4(2)],'b');
        plot([wp3(1) wp4(1)],[wp3(2) wp4(2)],'b');        
        pause()
        figure(2)
        %hmap =zeros(scale*2*height,scale*2*width);
        hmap =zeros(imheight,imwidth);
        %imshow(hmap);
        
        for jj=1:500
            startx = int32(midx+randn*width/5);
            starty = int32(midy+randn*height/5);
            cangomap=zeros(imheight,imwidth);

            for w=xxbar:xx2bar
                for h =yybar:yy2bar
                    cangomap(h,w) =1;
                end
            end

            energy=1;
            count =0;

            while(1)
                startx
                starty
                cangomap(starty,startx) =0;
                cost(1)= sum(im(starty-1,startx,:) - im(starty,startx,:));
                cost(2)= sum(im(starty+1,startx,:) - im(starty,startx,:));
                cost(3)= sum(im(starty,startx-1,:) - im(starty,startx,:));
                cost(4)= sum(im(starty,startx+1,:) - im(starty,startx,:));
                if cangomap(starty-1,startx) ==0
                    cost(1) =10000;
                end
                if cangomap(starty+1,startx) ==0
                    cost(2) =10000;
                end
                if cangomap(starty,startx-1) ==0
                    cost(3) =10000;
                end   
                if cangomap(starty,startx+1) ==0
                    cost(4) =10000;
                end
                cost
                [temp index] = min(cost)
                temp =temp+1;
                if temp>100 || count >10000
                    break;
                end

                if index ==1
                        hmap(starty-1,startx) = hmap(starty-1,startx)+ (1/temp*energy);
                        starty =starty-1;                    
                elseif index ==2
                        hmap(starty+1,startx) = hmap(starty+1,startx)+ (1/temp*energy);
                        starty =starty+1;                    
                elseif index ==3
                        hmap(starty,startx-1) = hmap(starty,startx-1)+ (1/temp*energy);
                        startx =startx-1;                   
                elseif index ==4
                        hmap(starty,startx+1) = hmap(starty,startx+1)+ (1/temp*energy);
                        startx =startx+1;                    
                end
                energy = 1/temp*energy;
                count = count+1            
            end
        end
        imshow(hmap)
        pause

    end
end


