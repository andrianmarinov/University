# Self organising maps

In order to test it run: 

1-D Self organising map
data=nicering;
som=lab_som(data, 30, 15000, 0.1, 15);
figure
lab_vis(som, data);

2-D Self organising map
lab_vis(som, data);
[som,grid]=lab_som2d(data, 10, 10, 15000, 0.1, 5);
figure
lab_vis2d(som, grid, data);
