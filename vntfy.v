
module main

import flag
import os
import v.vmod
import net.http
import net.websocket

fn set_value(s string) ?string {
	if s != '' {
		return s
	}
	return none
}

// GET PUB
fn pubs(api string){
	if os.args.len < 3 { 
	  exit(1) 
	}
	cmd := os.args[1]
	topic := os.args[2]
	msg := os.args[3..].join(' ')
	eprintln('cmd: $cmd topic: $topic msg: $msg')

	data := http.get_text('$api/$topic/publish?message=$msg')
	println(data)

}

// WS SUB
fn subs(api string, out string) {
	if os.args.len < 2 { 
	  exit(1) 
	}
	cmd := os.args[1]
	topic := os.args[2]
	opt := os.args[3..].join(' ')
	eprintln('cmd: $cmd topic: $topic opt: $opt')

	socket := api.replace('http', 'ws')
	mut ws := websocket.new_client(socket + '/' + topic + '/ws') or { exit(1) }
	// use on_message_ref if you want to send any reference object
	ws.on_message_ref(fn (mut ws websocket.Client, msg &websocket.Message, opt &string) ? {

		payload := if msg.payload.len == 0 { '' } else { string(msg.payload.bytestr()) }
		println(payload)
	}, opt)

	ws.connect() or { println('error on connect: $err') }
	ws.listen() or { println('error on listen $err') }
	unsafe {
		ws.free()
	}

}

fn main() {

	mut fp := flag.new_flag_parser(os.args)
	vm := vmod.decode( @VMOD_FILE ) or { panic(err.msg) }
        fp.application('$vm.name')
        fp.description('$vm.description')
        fp.version('$vm.version')
	fp.skip_executable()

	env_api := set_value(os.getenv('API')) or { 'https://ntfy.sh' }
	env_out := set_value(os.getenv('OUT')) or { 'json' }

	cmd := os.args[1]
	
	match cmd {
		'publish' { pubs(env_api) }
		'pub' { pubs(env_api) }
		'subscribe' { subs(env_api, env_out) }
		'sub' { subs(env_api, env_out) }
		else { println('unsupported command') }
	}
}

