module SystemInfo
  def self.sys_info
    @@sys_info ||= self.cpu_info.merge(self.mem_info)
  end

  def self.cpu_info #sorryforthisline
    @@cpu_info ||=  Hash[`lscpu`.split("\n").collect{|l| l = l.split(":"); [l[0].strip, l[1].strip]}]
  end

  def self.mem_info #sorryagain #itjustworks
    @@mem_info ||= Hash[`free -h`.split("\n")[1..-1].collect{|l| l = l.split(":"); [l[0].strip, l[1].split(" ")[0].strip]}].without("-/+ buffers/cache")
  end
end
