import net/ServerSocket, structs/ArrayList, threading/Thread, os/Time

Ircd: class {
    DEFAULT_ADDRESS      := "0.0.0.0"
    DEFAULT_PORT         := 6667
    DEFAULT_NUMACCEPTERS := 2
    DEFAULT_NUMLISTENERS := 2
    
    address: String
    port: Int
    socket: ServerSocket
    numAccepters: SSizeT
    numListeners: SSizeT
    conns     := ArrayList<TCPServerReaderWriterPair> new() // Wow, long.
    accepters := ArrayList<Thread> new()
    listeners := ArrayList<Thread> new()
    
    init: func(=address, =port, =numAccepters, =numListeners) {
        "Running IRCd on %s:%i, with %i accepters and %i listeners." printfln(address, port, numAccepters, numListeners)
        socket = ServerSocket new(address, port)
        socket listen()
        numAccepters times(||
            accepters += acceptThread()
        )
        numListeners times(||
            listeners += listenThread()
        )
    }
    
    init: func ~withAddressPortAccepters(.address, .port, .numAccepters) {
        init(address, port, numAccepters, DEFAULT_NUMLISTENERS)
    }
    
    init: func ~withAddressPort(.address, .port) {
        init(address, port, DEFAULT_NUMACCEPTERS)
    }
    
    init: func ~withPort(.port) {
        init(DEFAULT_ADDRESS, port)
    }
    
    init: func ~noArgs {
        init(DEFAULT_PORT)
    }

    acceptThread: func -> Thread {
        Thread new(|| acceptLoop())
    }
    
    acceptLoop: func {
        loop(||
            conns += socket accept()
            true
        )
    }
    
    listenThread: func -> Thread {
        Thread new(|| listenLoop())
    }
    
    listenLoop: func {
        loop(||
            "NOT IMPLEMENTED" println()
            true
        )
    }

    mainLoop: func {
        loop(||
            Time sleepSec(100)
            true
        )
    }
}

ircd := Ircd new()
ircd mainLoop()