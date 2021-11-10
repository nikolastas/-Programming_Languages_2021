      l=[]
      
      

      #----------------
      (x,y)=S
      visited=[] # λιστα με τουπλες που αναπαρηστουν τις συντεταγμενες του πινακα σελφ που εχουμε ηδη επισκευθει
      addneighbours(S,N,neighbours,visited) # συναρτηση που βαζει στην λιστα συντεγμενες με μορφη τουπλας που πρεπει να επισκευθουμε

     
      k=S
      while(neighbours!=NONE): # κανε οσο η λιστα γειτωνων δεν ειναι κενη
        k=(x,y)
        counter =0
        if( (x-1,y) is in visitedlist):
          counter++
        if( (x+1,y) is in visitedlist):
          counter++
        if( (x,y-1) is in visitedlist):
          counter++
        if( (x,y+1) is in visitedlist):
          counter++
        if (counter == 1 ):
          


        k=random.choice(neighbours)
      ## CODE END
## fun start
    def addneighbours(k,N, list, visited):
        if k in visited return
        k=(x,y)
        if(x> N or x<0 or y>N or x<0) return
        if()
        list.append(k)
    
## fun end