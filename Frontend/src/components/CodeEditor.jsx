import {Box, HStack, Stack, Tab, TabList, TabPanel, TabPanels, Tabs, Text} from "@chakra-ui/react";
import {useRef, useState} from "react";
import Output from "./Output.jsx";
import OneDarkPro from '../theme/onedarkpro.json';
import Input from "./Input.jsx";
import Navbar from "./Navbar.jsx";

const CodeEditor = () => {
    const editorRefs = useRef([]);
    const [tabIndex, setTabIndex] = useState(0);
    const [currentOutput, setCurrentOutput] = useState([]);
    const [tabsContent, setTabsContent] = useState([
        {
            'title': '*Untitled',
            'sourceCode': '//Hello World :)',
            'output': [],
        },
        {
            'title': '*Untitled(1)',
            'sourceCode': '//Hello World :(',
            'output': [],
        }
    ]);

    const optionsEditor = {
        scrollBeyondLastLine: false,
        fontSize: 16,
        fontFamily: 'Coda',
        //fontLigatures: true,
        //wordWrap: 'on',
        bracketPairColorization: {
            enabled: true
        },
        cursorBlinking: 'expand',
        formatOnPaste: true,
        renderValidationDecorations: "off"
    }

    const handleEditorDidMount = (monaco) =>{
        monaco.editor.defineTheme('OneDarkPro', {
            ...OneDarkPro
        });
    }

    const onChangeTab = (idx) => {
        setTabIndex(idx);
        setCurrentOutput(tabsContent[idx].output);
    };

    const onMount = (editor, index) => {
        editorRefs.current[index] = editor;
        editor.focus();
    };

    const getOutput = (output) => {
        const updatedTabs = [...tabsContent];
        updatedTabs[tabIndex].output = output;
        setTabsContent(updatedTabs);
        setCurrentOutput(output);
    };

    const getInput = (input) => {
        const updatedTabs = [...tabsContent];
        updatedTabs[tabIndex].sourceCode = input;
        setTabsContent(updatedTabs);
    }

    return (
        <Box minH='100vh' pr={5}>
            <HStack spacing={4} alignItems='start'>
                <Navbar getInput={getInput}/>
                <Input
                    tabsContent={tabsContent}
                    tabIndex={tabIndex}
                    onChangeTab={onChangeTab}
                    editorRefs={editorRefs}
                    onMount={onMount}
                    setTabsContent={setTabsContent}
                    optionsEditor={optionsEditor}
                    handleEditorDidMount={handleEditorDidMount}
                />
                <Output editorRef={editorRefs.current[tabIndex]} outputRef={currentOutput} getOutput={getOutput} />
            </HStack>
        </Box>
    );
};

export default CodeEditor;
