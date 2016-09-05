class Status < Enumerations::Base
  values ac:      { id: 1, name:  'Accepted' },
         wa:      { id: 2, name:  'Wrong Answer' },
         tle:     { id: 3, name:  'Time Limit Exceeded' },
         ce:      { id: 4, name:  'Compilation Error' },
         sigsegv: { id: 5, name:  'Runtime Error (SIGSEGV)' },
         sigxfsz: { id: 6, name:  'Runtime Error (SIGXFSZ)' },
         sigfpe:  { id: 8, name:  'Runtime Error (SIGFPE)' },
         sigabrt: { id: 9, name:  'Runtime Error (SIGABRT)' },
         nzec:    { id: 10, name: 'Runtime Error (NZEC)' },
         other:   { id: 11, name: 'Runtime Error (Other)' },
         sandbox: { id: 12, name: 'Internal Sandbox Error' }

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
