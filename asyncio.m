echoudp('on', 8000);
u = udp('127.0.0.1', 8000);
fopen(u)
u.Status
u.ReadAsyncMode = 'continuous';
fprintf(u, 'Hello net.');