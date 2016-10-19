protocol MetaObserver : Observer {
    func notifySubjectCreated(subject:Subject);
    func notifySubjectDestroyed(subject:Subject);
}

class MetaSubject : SubjectBase, MetaObserver {
    
    func notifySubjectCreated(subject: Subject) {
        sendNotification(Notification(type: NotificationTypes.SUBJECT_CREATED,
            data: subject));
    }
    
    func notifySubjectDestroyed(subject: Subject) {
        sendNotification(Notification(type: NotificationTypes.SUBJECT_DESTROYED,
            data: subject));
    }
    
    class var sharedInstance:MetaSubject {
        struct singletonWrapper {
            static let singleton = MetaSubject();
        }
        return singletonWrapper.singleton;
    }
    
    func notify(notification:Notification) {
        // do nothing - required for Observer conformance
    }
}

class ShortLivedSubject : SubjectBase {
    
    override init() {
        super.init();
        MetaSubject.sharedInstance.notifySubjectCreated(self);
    }
    
    deinit {
        MetaSubject.sharedInstance.notifySubjectDestroyed(self);
    }
}
