angular.module('receta').directive('saGeometryUpload', ->
  {
    scope: {
      text: '='
      id: '='
    }
    controller: ['$scope', '$http', ($scope, $http) ->
      $scope.text = "Select File" if $scope.text == "" or $scope.text == null
      $scope.uploadFile = (files) ->
        fd = new FormData()
        fd.append("geo", files[0])
        $http.post("geometry/#{$scope.id}/update_file", fd, {
          headers: {'Content-Type': undefined },
          transformRequest: angular.identity
        })
        .success (data) ->
          $scope.text = data.geometry.geo_file_name
        .error ->
          console.log('error uploading')
    ]
    restrict: 'E',
    template: '
        <span class="btn btn-default btn-file">
          <span class="upload-file-text">
            {{text}}
          </span>
          <input type="file" onchange="angular.element(this).scope().uploadFile(this.files)"/>
        </span>
    '
  }
)
