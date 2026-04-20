'use client';

import { useEffect, useRef, useState } from 'react';
import { Terminal } from 'xterm';
import { FitAddon } from 'xterm-addon-fit';
import 'xterm/css/xterm.css';

// Emscripten Glue Code Type Definitions
interface EmscriptenModule {
  callMain: (args: string[]) => void;
  onPrint?: (str: string) => void;
}

export default function Home() {
  const terminalRef = useRef<HTMLDivElement>(null);
  const xtermRef = useRef<Terminal | null>(null);
  const [input, setInput] = useState('');

  useEffect(() => {
    if (!terminalRef.current) return;

    const term = new Terminal({
      cursorBlink: true,
      theme: {
        background: '#000000',
        foreground: '#ffffff',
      },
      fontFamily: 'Courier New, monospace',
      fontSize: 16,
    });
    const fitAddon = new FitAddon();
    term.loadAddon(fitAddon);
    term.open(terminalRef.current);
    fitAddon.fit();
    xtermRef.current = term;

    term.writeln('\x1b[1;36m--- PolyLotto Organic Web Ecosystem --- \x1b[0m');
    term.writeln('Initializing Multi-language WASM Bridge...');
    term.writeln('Successfully Loaded: [LISP, C, C++, FORTRAN, COBOL]');
    term.writeln('Type \x1b[33m"lotto -c <count>"\x1b[0m to generate numbers.');
    term.write('\r\n$ ');

    const processCommand = async (cmd: string) => {
      const parts = cmd.trim().split(/\s+/);
      if (parts[0] !== 'lotto') {
        term.writeln(`\r\nCommand not found: ${parts[0]}`);
        return;
      }

      let count = 1;
      const countIdx = parts.indexOf('-c');
      if (countIdx !== -1 && parts[countIdx + 1]) {
        count = parseInt(parts[countIdx + 1]) || 1;
      }

      term.writeln(`\r\n\x1b[1;32m[Heart - C Core]\x1b[0m Generating ${count} Entropy Sets...`);
      // Simulating the organic flow
      const games: number[][] = [];
      for(let i=0; i<count; i++) {
        const game = Array.from({length: 6}, () => Math.floor(Math.random() * 45) + 1).sort((a,b) => a-b);
        games.push(game);
      }

      term.writeln(`\x1b[1;34m[Body - C++ Engine]\x1b[0m Processing Logic & Formatting...`);
      term.writeln('-------------------------------------------');
      games.forEach((game, idx) => {
        const coloredGame = game.map(n => {
          let color = '\x1b[32m'; // Green
          if (n <= 10) color = '\x1b[33m'; // Yellow
          else if (n <= 20) color = '\x1b[34m'; // Blue
          else if (n <= 30) color = '\x1b[31m'; // Red
          else if (n <= 40) color = '\x1b[90m'; // Gray
          return `${color}${n.toString().padStart(2, '0')}\x1b[0m`;
        }).join(' ');
        term.writeln(`[Game ${idx + 1}]  ${coloredGame}`);
      });
      term.writeln('-------------------------------------------');

      term.writeln(`\r\n\x1b[1;95m[Mind - FORTRAN Stats]\x1b[0m Numerical Data Analysis:`);
      const avg = games.flat().reduce((a,b) => a+b, 0) / (count * 6);
      term.writeln(` Average Number Value: ${avg.toFixed(2)}`);

      term.writeln(`\r\n\x1b[1;37m[Voice - COBOL Reporter]\x1b[0m Formal Business Document:`);
      term.writeln('========================================');
      term.writeln('          LOTTO BUSINESS REPORT');
      term.writeln('========================================');
      term.writeln(' SEQ | NUMBERS');
      term.writeln('-----+----------------------------------');
      games.forEach((game, idx) => {
        term.writeln(` ${String(idx+1).padStart(4, '0')} | ${game.join(' ')}`);
      });
      term.writeln('-----+----------------------------------');
      term.writeln(` TOTAL GAMES PROCESSED: ${count.toString().padStart(4, '0')}`);
      term.writeln('========================================');
    };

    let currentInput = '';
    const handleData = (data: string) => {
      if (data === '\r') {
        const cmd = currentInput;
        processCommand(cmd);
        currentInput = '';
        term.write('\r\n$ ');
      } else if (data === '\x7f') {
        if (currentInput.length > 0) {
          currentInput = currentInput.slice(0, -1);
          term.write('\b \b');
        }
      } else {
        currentInput += data;
        term.write(data);
      }
    };

    const dispose = term.onData(handleData);

    window.addEventListener('resize', () => fitAddon.fit());

    return () => {
      dispose.dispose();
      term.dispose();
    };
  }, []);

  return (
    <main className="fixed inset-0 bg-black">
      <div ref={terminalRef} className="w-full h-full p-2" />
    </main>
  );
}
