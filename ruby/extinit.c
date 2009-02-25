#include "ruby.h"

#define init(func, name) {void func _((void)); ruby_init_ext(name, func);}

void ruby_init_ext _((const char *name, void (*init)(void)));

void Init_ext _((void))
{
    init(Init_bigdecimal, "bigdecimal.so");
    init(Init_dbm, "dbm.so");
    init(Init_digest, "digest.so");
    init(Init_bubblebabble, "digest/bubblebabble.so");
    init(Init_md5, "digest/md5.so");
    init(Init_rmd160, "digest/rmd160.so");
    init(Init_sha1, "digest/sha1.so");
    init(Init_sha2, "digest/sha2.so");
    init(Init_etc, "etc.so");
    init(Init_fcntl, "fcntl.so");
    init(Init_wait, "io/wait.so");
    init(Init_nkf, "nkf.so");
    init(Init_pty, "pty.so");
    init(Init_cparse, "racc/cparse.so");
    init(Init_sdbm, "sdbm.so");
    init(Init_socket, "socket.so");
    init(Init_stringio, "stringio.so");
    init(Init_strscan, "strscan.so");
    init(Init_syck, "syck.so");
    init(Init_thread, "thread.so");
}
