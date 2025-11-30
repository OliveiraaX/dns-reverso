# 🔍 DNS Reverse & WHOIS Range Scanner

Script em **Bash** que realiza consulta WHOIS, extrai o range `inetnum`, gera todos os IPs do bloco e executa DNS Reverso (PTR) automaticamente.

Ideal para **pentest**, **mapeamento de rede**, **reconhecimento de infraestrutura** e **varredura de blocos IP**.

---

## 🚀 Funcionalidades

- ✔ Validação de IP com Regex  
- ✔ Consulta automática ao WHOIS  
- ✔ Extração automática do range `inetnum`  
- ✔ Isolamento do primeiro e último IP do bloco  
- ✔ Geração de todos os IPs do range  
- ✔ Consulta DNS reverso (`PTR`) em cada IP  
- ✔ Saída organizada e colorida  
- ✔ Tratamento de erros para WHOIS sem inetnum  

---

Executar com o IP desejado:

```bash
./dnsreverso.sh 127.0.0.1
```

```
Exemplo de saída
#######################################################################
#                                  DNS_REVERSO                        #
#######################################################################

Range encontrado:

inetnum:        37.59.174.224 - 37.59.174.239
----------------------------------------------------------------------

Realizando PTR nos IPs do range:

224.174.59.37.in-addr.arpa domain name pointer host224.example.com.
225.174.59.37.in-addr.arpa domain name pointer host225.example.com.
...
239.174.59.37.in-addr.arpa domain name pointer host239.example.com.
```
