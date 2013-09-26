using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class Message
{
    public Person Sender { get; set; }
    public Person Receiver { get; set; }
    public string MessageText { get; set; }
    public DateTime DispatchDate { get; set; }


    public Message(Person sender, Person receiver, string messageText, DateTime dispatchDate)
    {
        this.Sender = sender;
        this.Receiver = receiver;
        this.MessageText = messageText;
        this.DispatchDate = dispatchDate;
    }
}