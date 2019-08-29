%function:去除第一行的注释行
%-------------------------1.below maybe need changed:要处理的输入文件(a3m_file)目录-----------------------------------
input_path='';
%-------------------------1.below maybe need changed:处理后的输出文件(a3m_file)目录-----------------------------------
output_path='';
namelist= dir(strcat(input_path,'*.a3m'));
len = length(namelist);

for i=1:len
    data=[];
    file_name=namelist(i).name;
    file=strcat(path,file_name);
    [head,seqs]=fastaread(file);
    for j=1:length(head)
        data(j).Header=head{1,j};
        data(j).Sequence=seqs{1,j};
    end
    newfile=strcat(output_path,file_name);
    fastawrite(newfile,data);
end