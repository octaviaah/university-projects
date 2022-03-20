#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>

int main() {
  int c;
  struct sockaddr_in server;
  uint16_t a, b, suma;

  printf("Creating socket...\n");
  c = socket(AF_INET, SOCK_DGRAM, 0);
  if (c < 0) {
    printf("Eroare la crearea socketului client\n");
    return 1;
  }
  else printf ("Socket created successfully!\n");

  server.sin_port = htons(7777);
  server.sin_family = AF_INET;
  server.sin_addr.s_addr = inet_addr("127.0.0.1");
  memset(&server, 0, sizeof(server));
  printf("a=");
  scanf("%hu", &a);
  printf("b=");
  scanf("%hu", &b);
  printf("Sending '%hu' and '%hu'...\n", a, b);
  a = htons(a);
  b = htons(b);
  sendto(c, &a, sizeof(a), 0, (struct sockaddr *) &server, sizeof(server));
  sendto(c, &b, sizeof(b), 0, (struct sockaddr *) &server, sizeof(server));

  printf("Receiveing sum...\n");
  recvfrom(c, &suma, sizeof(suma), MSG_WAITALL, (struct sockaddr *) &server, sizeof(server));
  suma = ntohs(suma);
  printf("Receives '%hu'\n", suma);
  printf("Closing connection...\n");
  close(c);
}