public class ActionAdapter implements IAction<Element>
{
    private ActionAdapter next = null;
        
    public final void Invoke(Element sender)
    {
        this.Behavior(sender);
        if (this.next != null){
            this.next.Invoke(sender);  
        }
    }
    
    protected void Behavior(Element sender){
        //override this method in anonymous classes for profit.
    }
    
    
    public final void subscribe(ActionAdapter action){
        if (this.next == null){
            this.next = action; 
        } else {
            this.next.subscribe(action); 
        }        
    }    
    
    public final ActionAdapter unsubscribe(ActionAdapter action){
        ActionAdapter cursor = this;
        if (cursor == action){
            return (this.next != null) ? this.next : new ActionAdapter();
        } else {
            while (cursor.next != null){
                if (cursor.next == action){
                    this.skipNext();
                    break;
                } else {
                    cursor = cursor.next;  
                }
            }
        }
        return this;
    }
    
    private final void skipNext(){
        if (this.next != null){
            this.next = this.next.next;
        }
    }
    
}