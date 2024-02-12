function y = db(x)

% $Id: db.m 3 2004-02-04 12:57:04Z mairas $

y = spectrum(20*log10(abs(x.s)),x.frequency);
