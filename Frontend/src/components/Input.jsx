// Input.jsx
import { Box, Tabs, TabList, Tab, TabPanels, TabPanel, Text } from "@chakra-ui/react";
import { Editor } from "@monaco-editor/react";
//import OneDarkPro from '../theme/onedarkpro.json';

const Input = ({ tabsContent, tabIndex, onChangeTab, editorRefs, onMount, setTabsContent, optionsEditor, handleEditorDidMount }) => {
    return (
        <Box w="60%" minH='100%' py={5}>
            <Text mb={2} fontSize='lg' pb={4}>Input File</Text>
            <Tabs isManual variant='enclosed' onChange={onChangeTab} index={tabIndex} alignSelf={'end'} borderColor={'unset'}>
                <TabList>
                    {tabsContent.map((tab, i) => <Tab key={i}>{tab.title}</Tab>)}
                </TabList>
                <TabPanels border={'1px solid rgba(99,179,237,1)'}>
                    {tabsContent.map((tab, i) =>
                        <TabPanel p={0} key={i}>
                            <Editor
                                height="85vh"
                                theme="OneDarkPro"
                                defaultLanguage="typescript"
                                value={tab.sourceCode}
                                onMount={(editor) => onMount(editor, i)}
                                onChange={(value) => {
                                    const updatedTabs = [...tabsContent];
                                    updatedTabs[i].sourceCode = value;
                                    setTabsContent(updatedTabs);
                                }}
                                options={optionsEditor}
                                beforeMount={handleEditorDidMount}
                            />
                        </TabPanel>
                    )}
                </TabPanels>
            </Tabs>
        </Box>
    );
};

export default Input;