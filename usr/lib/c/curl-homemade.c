#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netdb.h>

#define BUFFER_CHUNK 4096

/* ---------------------- URL PARSING ---------------------- */
void parse_url(const char *input, char *host, size_t hsz, char *path, size_t psz)
{
    const char *slash = strchr(input, '/');

    if (slash) {
        size_t host_len = slash - input;
        if (host_len >= hsz) host_len = hsz - 1;
        strncpy(host, input, host_len);
        host[host_len] = '\0';
        snprintf(path, psz, "%s", slash);
    } else {
        snprintf(host, hsz, "%s", input);
        snprintf(path, psz, "/");
    }
}

/* ---------------------- CONNECT TO HOST ---------------------- */
int connect_to_host(const char *host)
{
    struct addrinfo hints = {0}, *res;
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;

    getaddrinfo(host, "80", &hints, &res);


    int sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (sock < 0) {
        perror("socket");
        freeaddrinfo(res);
        return -1;
    }

    if (connect(sock, res->ai_addr, res->ai_addrlen) < 0) {
        perror("connect");
        close(sock);
        freeaddrinfo(res);
        return -1;
    }

    freeaddrinfo(res);
    return sock;
}

/* ---------------------- SEND HTTP GET REQUEST ---------------------- */
int send_request(int sock, const char *host, const char *path)
{
    char req[1024];
    snprintf(req, sizeof(req),
             "GET %s HTTP/1.0\r\n"
             "Host: %s\r\n"
             "User-Agent: basic-c-client\r\n"
             "\r\n",
             path, host);

    return send(sock, req, strlen(req), 0);
}

/* ---------------------- DOWNLOAD RESPONSE ---------------------- */
char *download_response(int sock, size_t *out_size)
{
    char *filedata = NULL;
    *out_size = 0;

    char buffer[BUFFER_CHUNK];
    ssize_t bytes;

    while ((bytes = recv(sock, buffer, sizeof(buffer), 0)) > 0) {
        char *newbuf = realloc(filedata, *out_size + bytes + 1);
        if (!newbuf) {
            fprintf(stderr, "Out of memory\n");
            free(filedata);
            return NULL;
        }

        filedata = newbuf;
        memcpy(filedata + *out_size, buffer, bytes);
        *out_size += bytes;
        filedata[*out_size] = '\0';
    }

    return filedata;
}

/* ---------------------- MAIN PROGRAM ---------------------- */
int main(int argc, char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <host/path>\n", argv[0]);
        return 1;
    }

    char host[256];
    char path[512];
    parse_url(argv[1], host, sizeof(host), path, sizeof(path));

    int sock = connect_to_host(host);
    if (sock < 0) return 1;

    send_request(sock, host, path);

    size_t filesize;
    char *filedata = download_response(sock, &filesize);
    close(sock);

    if (!filedata) return 1;

    printf("Received %zu bytes:\n\n%s\n", filesize, filedata);
	f = open(argv[2], "w");
	write(f, filedata, filesize);

    free(filedata);
    return 0;
}

