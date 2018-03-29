function spirograph(R, l, k)
// spirograph() draws a spirograph (https://en.wikipedia.org/wiki/Spirograph)
// in the figure fig as specified by R, l, and k, where
//     * l = rho/r,
//     * k = r/R.
// Both x(t) and y(t) are defined as
//     x(t) = R*((1 - k)cos(t) + l*k cos((1 - k)*t/k),
//     y(t) = R*((1 - k)sin(t) - l*k sin((1 - k)*t/k).
//
// Note that the parameters l and k lie in the interval [0, 1].  At 0 or 1 the
// spirograph could degenerate into special trajectory.

// Constants
    NumPoints = 512;
    epsilon = 1.0e-4;   // threshold to determine when Point A starts to retrace
                        // itself.
                        
    // Checking the validity of input data.
    if (l < 0) || (l > 1) then
        warning('l error!');
    end
    if (k < 0) || (k > 1) then
        warning('k error!');
    end
    
    // Start the spirograph.  Initialize t as it sweeps around for 2*pi.  Note
    // that in general this does not lead to xt/yt retracing themselves, and
    // hence we need an infinite loop.
    t = linspace(0, 1, NumPoints)*(2*%pi);
    startingPoint = [];
    set(gca(), "auto_clear", "off");    // equivalent to "hold on" in Matlab
    
    // Adding title.
    titleStr = msprintf('Spirograph with l = %f and k = %f', l, k);
    title(titleStr);

    while %T
        // An infinite loop.  It breaks only when xt and yt start to retrace
        // themselves.
        xt = R*((1 - k)*cos(t) + (l*k)*cos((1 - k)*t/k));
        yt = R*((1 - k)*sin(t) - (l*k)*sin((1 - k)*t/k));
    
        if isempty(startingPoint) then
            // Setting startingPoint where we start so later we can check for
            // the occurence of retracing.
            startingPoint = [xt(1) yt(1)];
        else
            // Decide if we want to break from the loop or not, we draw the line
            // connecting the first point of the current iteration and the last
            // point of the previous iteration.
        
            dist2Start = sqrt((xt(1) - startingPoint(1))**2 + ...
                              (yt(1) - startingPoint(2))**2);
            if dist2Start < epsilon
                break;
            end
        end
    
        plot(xt, yt);
    
        // t for the next round.
        t = t + (2*%pi);
    end
    
endfunction
