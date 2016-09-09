class Status < Enumerations::Base
  values in_queue:  { id: 1,  name: 'In Queue' },
         ac:        { id: 2,  name: 'Accepted' },
         wa:        { id: 3,  name: 'Wrong Answer' },
         tle:       { id: 4,  name: 'Time Limit Exceeded' },
         ce:        { id: 5,  name: 'Compilation Error' },
         sigsegv:   { id: 6,  name: 'Runtime Error (SIGSEGV)' },
         sigxfsz:   { id: 7,  name: 'Runtime Error (SIGXFSZ)' },
         sigfpe:    { id: 8,  name: 'Runtime Error (SIGFPE)' },
         sigabrt:   { id: 9,  name: 'Runtime Error (SIGABRT)' },
         nzec:      { id: 10, name: 'Runtime Error (NZEC)' },
         other:     { id: 11, name: 'Runtime Error (Other)' },
         boxerr:    { id: 12, name: 'Internal Error' }

  def self.find_runtime_error_by_status_code(status_code)
    case status_code.to_i
      when 11 then Status.sigsegv
      when 25 then Status.sigxfsz
      when 8  then Status.sigfpe
      when 6  then Status.sigabrt
      else Status.other
    end
  end
end
