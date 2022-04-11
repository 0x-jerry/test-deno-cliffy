#!/usr/bin/env deno run --no-check

import {
  Command,
  StringType,
  CompletionsCommand,
} from 'https://deno.land/x/cliffy@v0.23.0/command/mod.ts'

class ScriptType extends StringType {
  complete() {
    return ['deno', 'cliffy']
  }
}

export const tt = new Command()
  .name('tt')
  .description('Run custom script in package.json, like yarn run.')
  .type('script', new ScriptType())
  .stopEarly()
  .arguments('<script:string:script> [...params:file]')
  .action((_, scriptName, params = []) => {
    console.log(scriptName, params)
  })

tt.version('v1.0.0').command('completions', new CompletionsCommand())

if (import.meta.main) {
  tt.parse()
}
