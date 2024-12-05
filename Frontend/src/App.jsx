import { useState } from 'react'

import {Box} from "@chakra-ui/react";
import CodeEditor from "./components/CodeEditor.jsx";

function App() {
  const [count, setCount] = useState(0)

  return (
    <Box minH="100vh" bg='#011627' color='gray.500' px={6} py={8} p={0} borderColor={'unset'}>
      <CodeEditor />
    </Box>
  )
}

//0f0a19

export default App
