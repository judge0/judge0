class Status < Enumerations::Base
  values queue:     { id:  1, name: 'In Queue' },
         process:   { id:  2, name: 'Processing' },
         ac:        { id:  3, name: 'Accepted' },
         wa:        { id:  4, name: 'Wrong Answer' },
         tle:       { id:  5, name: 'Time Limit Exceeded' },
         ce:        { id:  6, name: 'Compilation Error' },
         sigsegv:   { id:  7, name: 'Runtime Error (SIGSEGV)' },
         sigxfsz:   { id:  8, name: 'Runtime Error (SIGXFSZ)' },
         sigfpe:    { id:  9, name: 'Runtime Error (SIGFPE)' },
         sigabrt:   { id: 10, name: 'Runtime Error (SIGABRT)' },
         nzec:      { id: 11, name: 'Runtime Error (NZEC)' },
         other:     { id: 12, name: 'Runtime Error (Other)' },
         boxerr:    { id: 13, name: 'Internal Error' },
         exeerr:    { id: 14, name: 'Exec Format Error' }

  def self.find_runtime_error_by_status_code(status_code)
    case status_code.to_i
      when 11 then Status.sigsegv
      when 25 then Status.sigxfsz
      when 8  then Status.sigfpe
      when 6  then Status.sigabrt
      else Status.other
    end
  end

  def self.model_name
    @@model_name ||= ActiveModel::Name.new(self)
  end
end
