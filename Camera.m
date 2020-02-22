cam.VerticalFlip = true;
for i = 1:100
    img = snapshot(cam);
    image(img);
    drawnow;
end