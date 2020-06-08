## System Info [/system_info]
### System Info [GET]
System information gives you detailed information about system on which Judge0 is running.

This information is result of two commands on a host system:
- `lscpu`
- `free -h`

Please note that Judge0 consists of two systems: **web** and **worker**. **Web** system is the one who
provides you the web API, and **Worker** is the one who processes your submissions. They can be placed on two or more
different hosts with different system configurations. Result of this API request is always from web system.
This means that this request might be irrelevant to you if you as user don't know if web and worker are
hosted on the same machine. To find that out, please contact admins who host Judge0 you are using.
+ Response 200 (application/json)
    {
        "Architecture": "x86_64",
        "CPU op-mode(s)": "32-bit, 64-bit",
        "Byte Order": "Little Endian",
        "CPU(s)": "4",
        "On-line CPU(s) list": "0-3",
        "Thread(s) per core": "2",
        "Core(s) per socket": "2",
        "Socket(s)": "1",
        "NUMA node(s)": "1",
        "Vendor ID": "GenuineIntel",
        "CPU family": "6",
        "Model": "61",
        "Model name": "Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz",
        "Stepping": "4",
        "CPU MHz": "2508.703",
        "CPU max MHz": "2700.0000",
        "CPU min MHz": "500.0000",
        "BogoMIPS": "4392.12",
        "Virtualization": "VT-x",
        "L1d cache": "32K",
        "L1i cache": "32K",
        "L2 cache": "256K",
        "L3 cache": "3072K",
        "NUMA node0 CPU(s)": "0-3",
        "Mem": "7.7G",
        "Swap": "8.0G"
    }