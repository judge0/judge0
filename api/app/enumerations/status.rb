class Status < Enumerations::Base
  values ac:      { id: 1, name: 'Accepted' },
         wa:      { id: 2, name: 'Wrong Answer' },
         ce:      { id: 3, name: 'Compilation Error' },
         sigsegv: { id: 4, name: 'Runtime Error (SIGSEGV)' },
         sigxfsz: { id: 5, name: 'Runtime Error (SIGXFSZ)' },
         sigfpe:  { id: 6, name: 'Runtime Error (SIGFPE)' },
         sigabrt: { id: 7, name: 'Runtime Error (SIGABRT)' },
         nzec:    { id: 8, name: 'Runtime Error (NZEC)' },
         other:   { id: 9, name: 'Runtime Error (Other)' }
end
