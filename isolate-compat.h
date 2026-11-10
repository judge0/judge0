/*
 * Compatibility definitions for building isolate 2.x on Debian Buster
 * (Linux 4.19 kernel headers). These are needed for:
 *   - clone3 syscall (Linux 5.3+)
 *   - CLONE_INTO_CGROUP flag (Linux 5.7+)
 *   - quotactl_fd syscall (Linux 5.14+)
 *   - struct clone_args (Linux 5.3+)
 *
 * Syscall numbers are for amd64 (x86_64).
 */
#ifndef __ISOLATE_COMPAT_H
#define __ISOLATE_COMPAT_H

#include <linux/types.h>

/* clone3 syscall — amd64 number 435 */
#ifndef SYS_clone3
#define SYS_clone3 435
#endif

/* quotactl_fd syscall — amd64 number 443 */
#ifndef SYS_quotactl_fd
#define SYS_quotactl_fd 443
#endif

/* CLONE_INTO_CGROUP flag for clone3 */
#ifndef CLONE_INTO_CGROUP
#define CLONE_INTO_CGROUP 0x200000000ULL
#endif

/* io_uring syscalls (Linux 5.1+, amd64) — used by isolate's seccomp filter */
#ifndef __NR_io_uring_setup
#define __NR_io_uring_setup 425
#endif
#ifndef __NR_io_uring_enter
#define __NR_io_uring_enter 426
#endif
#ifndef __NR_io_uring_register
#define __NR_io_uring_register 427
#endif

/* struct clone_args — guard matches the kernel's own define */
#ifndef CLONE_ARGS_SIZE_VER0
#define CLONE_ARGS_SIZE_VER0 64
struct clone_args {
    __aligned_u64 flags;
    __aligned_u64 pidfd;
    __aligned_u64 child_tid;
    __aligned_u64 parent_tid;
    __aligned_u64 exit_signal;
    __aligned_u64 stack;
    __aligned_u64 stack_size;
    __aligned_u64 tls;
    __aligned_u64 set_tid;
    __aligned_u64 set_tid_size;
    __aligned_u64 cgroup;
};
#endif

#endif /* __ISOLATE_COMPAT_H */
