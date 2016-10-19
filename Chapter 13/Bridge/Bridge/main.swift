var comms = Communicator(channel: Channel.Channels.Satellite);

comms.sendCleartextMessage("Hello!");
comms.sendSecureMessage("This is a secret");
comms.sendPriorityMessage("This is important");
