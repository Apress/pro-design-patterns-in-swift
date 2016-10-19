let messages = [
    Message(from: "bob@example.com", to: "joe@example.com",
        subject: "Free for lunch?"),
    Message(from: "joe@example.com", to: "alice@acme.com",
        subject: "New Contracts"),
    Message(from: "pete@example.com", to: "all@example.com",
        subject: "Priority: All-Hands Meeting"),
];

if let chain = Transmitter.createChain(true) {
    for msg in messages {
        let handled = chain.sendMessage(msg);
        println("Message sent: \(handled)");
    }
}
