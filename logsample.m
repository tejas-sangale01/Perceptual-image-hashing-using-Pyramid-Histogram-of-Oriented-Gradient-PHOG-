function logarr = logsample(arr, rmin, rmax, xc, yc, nr, nw)
t = logtform(rmin, rmax, nr, nw);
nr = t.tdata.nr;        % Get computed values, in case default used
nw = t.tdata.nw;
[U, V, ~] = size(arr);
Udata = [1, V] - xc;
Vdata = [1, U] - yc;
Xdata = [0, nr-1];
Ydata = [0, nw-1];
Size = [nw, nr];
logarr = imtransform(arr, t,'Udata', Udata, 'Vdata', Vdata,'Xdata', Xdata, 'Ydata', Ydata, 'Size', Size);
end