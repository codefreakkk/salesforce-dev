const events = {};

    // subscribe to an event
 const   subscribe = (eventName, callback) => {
        if (!events[eventName]) {
            events[eventName] = [];
        }
        events[eventName].push(callback);
    }

    // publish an event
const  publish=  (eventName, payload) => {
        if (events[eventName] && events[eventName].length > 0) {
            events[eventName].forEach((callback) => callback(payload));
        }
    }
    // unsubscribe an event 
  const  unsubscribe = (eventName, callback) => {
        if (events[eventName] && events[eventName].length > 0) {
            events[eventName] = events[eventName].filter((currentCallback) => currentCallback !== callback);
        }
    }

    export  {
        subscribe, publish, unsubscribe
    }