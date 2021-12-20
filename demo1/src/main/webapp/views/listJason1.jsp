<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
        <%
            pageContext.setAttribute("APP_PATH", request.getContextPath());
        %>
        <!-- web路径：
        不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
        以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
                http://localhost:3306/crud
         -->
        <script type="text/javascript"
                src="${APP_PATH }/static/js/http_cdn.staticfile.org_jquery_2.1.1_jquery.js"></script>
        <link
                href="${APP_PATH }/static/css/http_cdn.staticfile.org_twitter-bootstrap_3.3.7_css_bootstrap.css"
                rel="stylesheet">
        <script
                src="${APP_PATH }/static/js/http_cdn.staticfile.org_twitter-bootstrap_3.3.7_js_bootstrap.js"></script>
    </head>
    <body>
        <!-- Add emp -->
        <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Add Employee</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="inputEmpName" class="col-sm-2 control-label">EmpName</label>
                                <div class="col-sm-10">
                                    <input type="text" name="empName" class="form-control" id="inputEmpName" placeholder="empName">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Gender</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="InputGender1" value="option1" checked="checked"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="InputGender2" value="option2"> 女
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-10">
                                    <input type="text" name="email" class="form-control" id="inputEmail" placeholder="Email">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Dept Id</label>
                                <div class="col-sm-4">
                                    <select name="dId" class="form-control">
                                        <option>1</option>
                                        <option>2</option>
                                        <option>3</option>
                                        <option>4</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 搭建显示页面 -->
        <div class="container">
            <!-- 标题 -->
            <div class="row">
                <div class="col-md-12">
                    <h1>SSM-CRUD</h1>
                </div>
            </div>
            <!-- 按钮 -->
            <div class="row">
                <div class="col-md-4 col-md-offset-8">
                    <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
                    <button class="btn btn-danger" id="emp_delete_modal_btn">删除</button>
                </div>
            </div>

            <!-- 显示表格数据 -->
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-hover" id="emps_table">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>empName</th>
                                <th>gender</th>
                                <th>email</th>
                                <th>deptName</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody></tbody>

                    </table>
                </div>
            </div>

            <!-- 显示分页信息 -->
            <div class="row">
                <div class="col-md-6" id="page_info_area"></div>
                <!-- 分页条信息 -->
                <div class="col-md-6" id="page_nav_area"></div>
            </div>

        </div>

        <script type="text/javascript">
            var totalRecord,currentPage;
            $(function(){
                to_page(1);
            });

            function to_page(pn){
                $.ajax({
                    url:"${APP_PATH}/empsJason",
                    data:"pn="+pn,
                    type:"GET",
                    success:function(result){
                        //console.log(result);
                        //1、解析并显示员工数据
                        build_emps_table(result);
                        //2、解析并显示分页信息
                        build_page_info(result);
                        //3、解析显示分页条数据
                        build_page_nav(result);
                    }
                });
            }

            function build_emps_table(result) {
                var emps = result.extend.pageInfo.list;
                $("#emps_table tbody").empty();
                $.each(emps,function(index, item){
                    var empIdTd = $("<td></td>").append(item.empId);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var gender = (item.gender==="M"?"Male":"Female");
                    var genderTd = $("<td></td>").append(gender);
                    var emailTd = $("<td></td>").append(item.email);
                    var deptNameTd = $("<td></td>").append(item.department.deptName);
                    var editBtn = $("<button></button>").addClass("btn btn-primary").append($("<span></span>")).append("edit");
                    var deleteBtn = $("<button></button>").addClass("btn btn-danger").append($("<span></span>")).append("delete");
                    var btnTd = $("<td></td>").append(editBtn).append("  ").append(deleteBtn);
                    $("<tr></tr>").append(empIdTd)
                                    .append(empNameTd)
                                    .append(genderTd)
                                    .append(emailTd)
                                    .append(deptNameTd)
                                    .append(btnTd)
                                    .appendTo("#emps_table tbody");
                })
            }

            function build_page_info(result) {
                $("#page_info_area").empty();
                $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum
                                            + "页,总"
                                            + result.extend.pageInfo.pages
                                            + "页,总"
                                            + result.extend.pageInfo.total + "条记录");
            }

            function build_page_nav(result) {
                //page_nav_area
                $("#page_nav_area").empty();
                var ul = $("<ul></ul>").addClass("pagination");

                //构建元素
                var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
                var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
                if (result.extend.pageInfo.hasPreviousPage === false) {
                    firstPageLi.addClass("disabled");
                    prePageLi.addClass("disabled");
                } else {
                    //为元素添加点击翻页的事件
                    firstPageLi.click(function () {
                        to_page(1);
                    });
                    prePageLi.click(function () {
                        to_page(result.extend.pageInfo.pageNum - 1);
                    })
                }


                var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
                var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
                if (result.extend.pageInfo.hasNextPage === false) {
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");
                } else {
                    nextPageLi.click(function () {
                        to_page(result.extend.pageInfo.pageNum + 1);
                    });
                    lastPageLi.click(function () {
                        to_page(result.extend.pageInfo.pages);
                    })
                }


                //添加首页和前一页 的提示
                ul.append(firstPageLi).append(prePageLi);
                //1,2，3遍历给ul中添加页码提示
                $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

                    var numLi = $("<li></li>").append($("<a></a>").append(item));
                    if (result.extend.pageInfo.pageNum === item) {
                        numLi.addClass("active");
                    }
                    numLi.click(function () {
                        to_page(item);
                    });
                    ul.append(numLi);
                });
                //添加下一页和末页 的提示
                ul.append(nextPageLi).append(lastPageLi);

                //把ul加入到nav
                var navEle = $("<nav></nav>").append(ul);
                navEle.appendTo("#page_nav_area");
            }

            $("#emp_add_modal_btn").click(function () {

                getDepts();

                $("#empAddModal").modal({
                    backdrop: "static"
                })
            });

            function getDepts() {
                $.ajax({
                    url:"${APP_PATH}/depts",
                    type:"GET",
                    success: function (result) {

                    }
                })
            }
        </script>
    </body>
</html>