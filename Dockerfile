FROM swipl

WORKDIR /home

COPY . .

# CMD ["bash", "-c",  "./server.pl"]

CMD ["swipl", "server.pl"]
